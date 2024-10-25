import com.wisecoders.dbs.diagram.model.Callout
import com.wisecoders.dbs.diagram.model.Depict
import com.wisecoders.dbs.diagram.model.Group
import com.wisecoders.dbs.diagram.model.Point
import com.wisecoders.dbs.schema.*
import javafx.scene.paint.Color

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.stream.Stream;

// Connection parameters
def conn_alias = "pg"
def conn_dbmsName = "PostgreSQL"
def conn_driver = "org.postgresql.Driver"
def conn_jdbcUrl = "jdbc:postgresql://" + System.getenv("DB_HOST") + ":" + System.getenv("DB_PORT") + "/" + System.getenv("DB_NAME")
def conn_username = "postgres"
def conn_password = "postgres"

// Color maps according to table prefixes
def backgroundColorMap = [
        "dim" :"#c4e0f9",
        "fact" :"#feea9b",
]

def foregroundColorMap = [
        "dim" :"#96c8f4", 
        "fact" :"#fddf69",
]


try {
    // Make sure to have the PostgreSQL driver
    com.wisecoders.dbs.cli.command.connectivity.DownloadDriverCommand.downloadDriver(conn_dbmsName)

    // Create sample project
    Project project = new Project("sample", conn_dbmsName);

    // Create a connection to the PostgreSQL database
    Connector con = ConnectorManager.createConnector(
        conn_alias,
        conn_dbmsName,
        conn_driver,
        conn_jdbcUrl,
        conn_username,
        conn_password
    )

    // Import "public" schema
    def dbSchema = "public"
    Schema schema = con.importSchema(project, dbSchema)
    println "processing schema: ${schema}"

    // Creating layout and groups
    Layout layout = project.createLayout("ERD-${schema}")
    def grps = ["defaultKey": null]

    // Create layout in the project. We are creating a single one.
    // See https://dbschema.com/documentation/layouts.html for more information,
    for (Table table: schema.tables){

        // We expect all table name to have a "dim_" or "fact_" prefix...
        String tableType = table.getName().split('_')[0]
        table.setComment("COMMENT ON TABLE ${table.getName()}")
        bgColor = backgroundColorMap.get(tableType)
        fgColor = foregroundColorMap.get(tableType)

        if(!grps.containsKey(tableType)){
            Group grp = layout.diagram.createGroup(tableType)
            grps.put(tableType, grp)
            println "Add layout group for domain ${tableType}"
        }

        grp = grps.get(tableType)

        Depict depict = layout.attach( table )
        depict.setComment("COMMENT STRING")

        //depict.hideColumnsIfDepictIsLarge()

        grp.attachDepict( depict )
        grp.setColor(Color.web(bgColor))
        println "Add table ${table}"
    }
    layout.autoArrange()

    // Export HTML5 documentation
    def outputDir = new File(System.getenv("OUTPUT_PATH"))
    def outputFile = outputDir.getPath() + "/erd_" + dbSchema.toLowerCase() + ".html"

    // Create the output directory in case it doesn't exist
    if (!outputDir.exists()) {
        outputDir.mkdirs()
    }

    htmlFile = new File(outputFile)

    println "general html file: ${outputFile}"
    layout.generateHtmlDocumentation( htmlFile, [layout] )

} 

// Ensure the script exits with a non-zero status on failure
catch (Exception e) {
    println "Script failed: ${e.message}"
    e.printStackTrace()
    System.exit(1)  
}

// Explicitly exit with 0 if the script succeeds
System.exit(0)