package de.bund.bfr.rakip.validator

import com.fasterxml.jackson.databind.SerializationFeature
import freemarker.cache.ClassTemplateLoader
import io.ktor.application.*
import io.ktor.features.*
import io.ktor.freemarker.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.jackson.*
import io.ktor.response.*
import io.ktor.routing.*

fun Application.module() {

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

        static("/static") {
            resources("files")
        }
    }
}

// Local test
fun main(args: Array<String>): Unit = io.ktor.server.tomcat.EngineMain.main(args)