using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography.X509Certificates;
using System.Web.Http;

namespace keep.Controllers
{
    public class MainController : ApiController
    {
        KeepEntities db = new KeepEntities();
        [HttpPost]
        public IHttpActionResult login([FromBody] JObject jsonData)
        {
            var res = new JObject();
            if (db.Users.ToList().FirstOrDefault(x => x.Password == jsonData["password"].ToString() && x.Name == jsonData["account"].ToString()) is { } acc)
            {
                var keeps = new JArray();
                foreach (var item in acc.Keeps)
                {
                    var keepContent = JObject.FromObject(new
                    {
                        id = item.ID,
                        title = item.Title,
                        date = item.CreateDate.ToString("yyyy-MM-dd"),
                        userId = item.UserID,
                        data = item.Data,
                        type = item.KeepTypeID,
                        color = item.KeepTypes.Color
                    });
                    keeps.Add(keepContent);
                }
                res.Add("res", keeps);
                res.Add("id", acc.ID);
                res.Add("state", "success");
                return Ok(res);
            }
            res.Add("state", "fail");
            return Ok(res);
        }

        [HttpGet]
        public IHttpActionResult getAllKeeps()
        {
            return Ok(JArray.FromObject(db.Keeps.Select(x => new
            {
                id = x.ID,
                title = x.Title,
                userId = x.UserID,
                data = x.Data,
                date = x.CreateDate,
                type = x.KeepTypeID
            })));
        }

        [HttpPost]
        public IHttpActionResult getUserKeeps([FromBody] JObject jsonData)
        {
            var res = new JObject();
            res.Add("id", jsonData["id"]);
            res.Add("res", JArray.FromObject(db.Keeps.ToList().Where(x => x.UserID.ToString() == jsonData["id"].ToString()).Select(x => new
            {
                id = x.ID,
                title = x.Title,
                date = x.CreateDate.ToString("yyyy-MM-dd"),
                userId = x.UserID,
                data = x.Data,
                type = x.KeepTypeID,
                color = x.KeepTypes.Color
            })));
            return Ok(res);
        }

        [HttpPost]
        public IHttpActionResult updateKeep([FromBody] JObject jsonData)
        {
            var keep = new Keeps();
            keep.ID = long.Parse(jsonData["id"].ToString()) == -1 ? db.Keeps.Max(x => x.ID) + 1 : long.Parse(jsonData["id"].ToString());
            keep.Title = jsonData["title"].ToString();
            keep.Data = jsonData["data"].ToString();
            keep.CreateDate = DateTime.Parse(jsonData["date"].ToString());
            keep.UserID = long.Parse(jsonData["userId"].ToString());
            keep.KeepTypeID = long.Parse(jsonData["type"].ToString());
            db.Keeps.AddOrUpdate(keep);
            db.SaveChanges();
            return Ok();
        }

        [HttpPost]
        public IHttpActionResult deleteKeep([FromBody] JObject jsonData)
        {
            var keep = db.Keeps.ToList().FirstOrDefault(x => x.ID.ToString() == jsonData["id"].ToString());
            db.Keeps.Remove(keep);
            db.SaveChanges();

            return Ok();
        }
    }
}
