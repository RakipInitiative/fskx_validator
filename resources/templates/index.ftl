<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-wEmeIV1mKuiNpC+IOBjI7aAzPcEZeedi5yW5f2yOq55WWLwNGmvvx4Um1vskeMj0" crossorigin="anonymous">

    <title>FSKX Validator</title>

    <script>
        let URL = "${viewData.endpoint}";  // Backend url
        let CONTEXT = "${viewData.context}";
    </script>
</head>
<body>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
            crossorigin="anonymous"></script>

    <div class="container">
        <h1>FSKX Validator</h1>

        <div class="input-group mb-3">
            <input class="form-control" type="file" id="fileInput">
            <button id="validateButton" class="btn btn-primary">Validate</button>
        </div>

        <div id="resultsDiv mb-3">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Check</th>
                        <th>Results</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <th scope="row">CombineArchive check</th>
                        <td id="combineArchiveCheck"></td>
                    </tr>
                    <tr>
                        <th scope="row">Structure check</th>
                        <td id="structureCheck"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function createAlert(type, text) {
            if (type === "correct") {
                return "<div class='alert alert-success' role='alert'>Correct</div>";
            } else if (type === "incorrect") {
                return "<div class='alert alert-danger' role='alert'>" + text + "</div>";
            } else if (type === "warning") {
                return "<div class='alert alert-warning' role='alert'>" + text + "</div>";
            }
        }

        function updateResultsDiv(checks) {

            // Update combineArchiveCheck
            let combineArchiveResult = checks[0];
            let combineArchiveCheck = document.getElementById("combineArchiveCheck");
            combineArchiveCheck.innerHTML = "";
            if (combineArchiveResult.error) {
                combineArchiveCheck.innerHTML += createAlert("incorrect", combineArchiveResult.error);
            } else {
                combineArchiveCheck.innerHTML += createAlert("correct", "");
            }
            for (warning of combineArchiveResult.warnings) {
                combineArchiveCheck.innerHTML += "<p>" + warning + "</p>";
            }

            // Update structureCheck
            let structureResult = checks[1];
            let structureCheck = document.getElementById("structureCheck");
            structureCheck.innerHTML = "";
            if (structureCheck.error) {
                structureCheck.innerHTML += createAlert("incorrect", structureCheck.error);
            } else {
                structureCheck.innerHTML += createAlert("correct", "");
            }
            for (warning of structureResult.warnings) {
                structureCheck.innerHTML += "<p>" + warning + "</p>";
            }
        }

        document.getElementById("validateButton").onclick = () => {
            let file = document.getElementById("fileInput").files[0];
            let data = new FormData();
            data.append('file', file);
            data.append('user', 'webapp');
            fetch(URL + "/" + CONTEXT + "/validate", { method: 'POST', body: data })
                .then(resp => resp.json())
                .then(data => updateResultsDiv(data.checks));
        }

    </script>
</body>
</html>
