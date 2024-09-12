import com.wisecoders.dbs.schema.*

Project proj = new Project("sample", "SqlServer");
println "Project " + proj.getName()
// CONNECT TO A LOCAL INSTALLED SQLSERVER, DATABASE 'hr' AS USER sa
Connector con = ConnectorManager.createConnector("pg_con", "org.postgresql.Driver", "jdbc:postgresql://localhost:5432/testdb", "postgres", "postgres")
// HERE SPECIFY THE CONNECTION PASSWORD
con.setPassword("postgres")
// Sample connection using the JDBC URL
// ConnectorManager.createConnector("test","MongoDb", "com.wisecoders.dbschema.mongodb.JdbcDriver","mongodb://localhost/tournament", "", "");

con.importSchemes( proj, "public")

for( Schema sch : project.schemas ){
    out.println( "Schema " + sch.getNameWithCatalog() )
    for ( Table table : sch.tables ){
        out.println( "  Table " + table.getName() )
    }
}