<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FSKX Validator</title>
</head>
<body>
    <h1>FSKX Validator</h1>
    <p><input id="fileInput" type="file"> <button id="validateButton">Validate</button></p>
    <div>
        <p>Results</p>
        <div id="resultsDiv">
            <table>
                <tbody>
                    <tr>
                        <td>CombineArchive check</td>
                        <td id="combineArchiveCheck"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <script>
        function updateResultsDiv(checks) {
            let resultsDiv = document.getElementById("resultsDiv");

            // Update combineArchiveCheck
            let combineArchiveResult = checks[0];
            let combineArchiveCheck = document.getElementById("combineArchiveCheck");
            combineArchiveCheck.innerHTML = "";
            if (combineArchiveResult.error) {
                combineArchiveCheck.innerHTML += "<p>" + combineArchiveResult.error + "</p>";
            }
            for (warning of combineArchiveResult.warnings) {
                combineArchiveCheck.innerHTML += "<p>" + warning + "</p>";
            }
        }

        document.getElementById("validateButton").onclick = () => {
            let file = document.getElementById("fileInput").files[0];
            let data = new FormData();
            data.append('file', file);
            data.append('user', 'webapp');
            fetch("/validate", { method: 'POST', body: data })
                .then(resp => resp.json())
                .then(data => updateResultsDiv(data.checks));
        }

    </script>
</body>
</html>
