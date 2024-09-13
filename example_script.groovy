import com.wisecoders.dbs.schema.*

try {

    Project proj = new Project("sample", "SqlServer");
    println "Project " + proj.getName()
    // CONNECT TO A LOCAL INSTALLED SQLSERVER, DATABASE 'hr' AS USER sa
    Connector con = ConnectorManager.createConnector("pg_con", "localhost" 5432, "org.postgresql.Driver", "postgres", "postgres")
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

} catch (Exception e) {
    println "Script failed: ${e.message}"
    e.printStackTrace()
    System.exit(1)  // Ensure the script exits with a non-zero status on failure
}

// Explicitly exit with 0 if the script succeeds
System.exit(0)