﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace keep
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class KeepEntities : DbContext
    {
        public KeepEntities()
            : base("name=KeepEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<KeepLogs> KeepLogs { get; set; }
        public virtual DbSet<Keeps> Keeps { get; set; }
        public virtual DbSet<Users> Users { get; set; }
        public virtual DbSet<KeepTypes> KeepTypes { get; set; }
    }
}