# ORM Tools

Example `TypeORM`

## ManyToOne

Example... many municipalities can have the same district and one district can have many municipalities.
You need decorator on both sides, even if only municipalities have districtz-foreign key, to inverse the relationship,
to e.g. get all municipalities belonging to a district.

```ts
@Entity()
export class Municipality {
    @ManyToOne(() => District, , district => district.municipalities)
    @JoinColumn({ name: "district_id" }) // Explicitly specify the foreign key column name
    district?: District;
```

```ts
@Entity()
export class District {
    @OneToMany(() => Municipality, municipality => municipality.district)
    municipalities?: Municipality[];
```

- The `@JoinColumn` decorator is used to specify the foreign key column in the **owning side** of the relationship. In this case, the Municipality entity is the owning side of the relationship because it contains the foreign key column (`district_id`). Therefore, the `@JoinColumn` decorator is used in the Municipality entity to specify the foreign key column.

- `@OneToMany(() => Municipality, municipality => municipality.district)`: This decorator defines a one-to-many relationship from District to Municipality. It indicates that one District can have multiple Municipality entities. The second part (`municipality => municipality.district`) specifies the property on the Municipality entity that refers back to the District.

## ManyToMany

In a relational database, a many-to-many relationship is typically implemented using a join table (also known as a junction table or associative table).
This join table contains foreign keys that reference the primary keys of the two tables involved in the many-to-many relationship.

You should specify the join table in your Node.js/TypeORM setup to accurately reflect the many-to-many relationship between Municipality and Association. You can define the join table as an entity or use the @ManyToMany and @JoinTable decorators to let TypeORM handle it automatically.

In a many-to-many relationship, the properties that define the relationship (associations in Municipality and municipalities in Association) are not directly stored as columns in the respective tables. Instead, they are represented by a join table that holds the foreign keys referencing the primary keys of the related entities.

Only specify the @JoinTable decorator on one side of the relationship. This decorator indicates that the entity owning the relationship will have a join table created for it. You can choose either side of the relationship to specify the @JoinTable decorator, but it is typically done on the side that is more logical for your application.

```ts
export class Municipality {

    @ManyToMany(() => Association, association => association.municipalities)
        @JoinTable({
            name: "municipality_association", // Custom join table name
            joinColumn: {
                name: "municipality_id",
                referencedColumnName: "id"
            },
            inverseJoinColumn: {
                name: "association_id",
                referencedColumnName: "id"
            }
        })
        associations?: Association[];
```

## EF Core vs TypeORM

### C# with annotations

```c#
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class Quantity
{
    [Key, Column(Order = 0)]
    [MaxLength(5)]
    public string MunicipalityId { get; set; }

    [Key, Column(Order = 1)]
    [MaxLength(13)]
    public string DisposalContractorId { get; set; }

    [Key, Column(Order = 2)]
    [MaxLength(5)]
    public string WasteTypeId { get; set; }

    [Key, Column(Order = 3)]
    public DateTime Date { get; set; }

    public long PlausibleQuantity { get; set; }

    [ForeignKey("MunicipalityId")]
    public Municipality Municipality { get; set; }

    [ForeignKey("DisposalContractorId")]
    public DisposalContractor DisposalContractor { get; set; }

    [ForeignKey("WasteTypeId")]
    public WasteType WasteType { get; set; }
}
```

### C# with Fluent API

```c#
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

public class MunicipalityAssociation
{
    [Key]
    public string MunicipalityId { get; set; }
    public Municipality Municipality { get; set; }

    [Key]
    public long AssociationId { get; set; }
    public Association Association { get; set; }
}

using Microsoft.EntityFrameworkCore;

public class ApplicationDbContext : DbContext
{
    public DbSet<District> Districts { get; set; }
    public DbSet<Association> Associations { get; set; }
    public DbSet<Municipality> Municipalities { get; set; }
    public DbSet<MunicipalityAssociation> MunicipalityAssociations { get; set; }
    public DbSet<Quantity> Quantities { get; set; }
    public DbSet<DisposalContractor> DisposalContractors { get; set; }
    public DbSet<WasteType> WasteTypes { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<MunicipalityAssociation>()
            .HasKey(ma => new { ma.MunicipalityId, ma.AssociationId });

        modelBuilder.Entity<MunicipalityAssociation>()
            .HasOne(ma => ma.Municipality)
            .WithMany(m => m.MunicipalityAssociations)
            .HasForeignKey(ma => ma.MunicipalityId);

        modelBuilder.Entity<MunicipalityAssociation>()
            .HasOne(ma => ma.Association)
            .WithMany(a => a.MunicipalityAssociations)
            .HasForeignKey(ma => ma.AssociationId);

        base.OnModelCreating(modelBuilder);
    }
}
```

### TypeORM

```ts
import { Entity, Column, ManyToOne, JoinColumn, PrimaryColumn } from "typeorm";
import { Municipality } from "./municipality";
import { DisposalContractor } from "./disposalContractor";
import { WasteType } from "./wasteType";

@Entity()
export class Quantity {
    @PrimaryColumn({ type: 'char', length: 5 })
    municipality_id: string;

    @PrimaryColumn({ type: 'char', length: 13 })
    disposal_contractor_id: string;

    @PrimaryColumn({ type: 'char', length: 5 })
    waste_type_id: string;

    @PrimaryColumn({ type: 'date' })
    date: Date;

    @Column({ type: 'bigint' })
    plausible_quantity: number;

    @ManyToOne(() => Municipality)
    @JoinColumn({ name: "municipality_id" })
    municipality: Municipality;

    @ManyToOne(() => DisposalContractor)
    @JoinColumn({ name: "disposal_contractor_id" })
    disposalContractor: DisposalContractor;

    @ManyToOne(() => WasteType)
    @JoinColumn({ name: "waste_type_id" })
    wasteType: WasteType;
}
```
