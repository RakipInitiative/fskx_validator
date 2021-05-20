import de.bund.bfr.rakip.validator.CodeChecker
import org.junit.Test
import java.io.File
import kotlin.test.assertTrue

class CodeCheckerTest {

    @Test
    fun testValidFile() {
        val file = File("testresources/toymodel.fskx")
        val checkResult = CodeChecker().check(file)

        assertTrue(checkResult.error.isEmpty())
        assertTrue(checkResult.warnings.isEmpty())
    }
}