package de.bund.bfr.rakip.validator

import de.unirostock.sems.cbarchive.CombineArchive
import de.unirostock.sems.cbarchive.CombineArchiveException
import java.io.File

data class CheckResult(val error: String, val warnings: List<String>)
data class ValidationResult(val isValid: Boolean, val checks: List<CheckResult>)

interface Checker {
    fun check(file: File): CheckResult
}

class CombineArchiveChecker : Checker {

    /**
     * Check if the passed file is a valid CombineArchive.
     *
     * @return If valid a CheckResult with empty error and warnings. If invalid a CheckResult with an error and no
     * warnings.
     */
    override fun check(file: File): CheckResult {
        return try {
            CombineArchive(file)
            CheckResult("", emptyList())
        } catch (err: CombineArchiveException) {
            CheckResult(err.message ?: "", emptyList())
        }
    }
}
