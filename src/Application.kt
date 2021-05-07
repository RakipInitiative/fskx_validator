package de.bund.bfr.rakip.validator

import com.fasterxml.jackson.databind.SerializationFeature
import freemarker.cache.ClassTemplateLoader
import io.ktor.application.*
import io.ktor.features.*
import io.ktor.freemarker.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.jackson.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import java.io.File
import kotlin.io.path.ExperimentalPathApi
import kotlin.io.path.createTempDirectory

@OptIn(ExperimentalPathApi::class)
fun Application.module(testing: Boolean = false) {

    val TEMP_FOLDER = createTempDirectory("uploads")

    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }

    install(CORS) {
        header(HttpHeaders.AccessControlAllowOrigin)
        allowCredentials = true
        anyHost() // @TODO: Don't do this in production if possible. Try to limit it.
    }

    install(ContentNegotiation) {
        jackson {
            configure(SerializationFeature.INDENT_OUTPUT, true)
        }
    }
    install(DefaultHeaders)

    routing {

        val viewData = object {} // TODO: fill viewData
        get("/") {
            call.respond(FreeMarkerContent("index.ftl", mapOf("viewData" to viewData), ""))
        }

        /*
         * Body parameter: form data:
         * - file: Binary object
         * - user: User name (string)
         */
        post("/validate") {
            val multipartData = call.receiveMultipart()

            var file: File? = null
            multipartData.forEachPart { part ->
                // if part is a file (could be form item)
                if(part is PartData.FileItem) {
                    // retrieve file name of upload
                    val name = part.originalFileName!!

                    val fileCopy = kotlin.io.path.createTempFile(TEMP_FOLDER, name).toFile()
                    fileCopy.deleteOnExit()

                    val fileBytes = part.streamProvider().readBytes()
                    fileCopy.writeBytes(fileBytes)

                    file = fileCopy
                }
                // make sure to dispose of the part after use to prevent leaks
                part.dispose()
            }

            if (file != null) {
                // TODO: validate file
                call.respond(HttpStatusCode.OK)
            }
            println("TODO: /validate")
        }

        static("/static") {
            resources("files")
        }
    }
}

// Local test
fun main(args: Array<String>): Unit = io.ktor.server.tomcat.EngineMain.main(args)