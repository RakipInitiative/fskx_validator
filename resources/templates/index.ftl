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
        <div></div>
    </div>
    <script>
        document.getElementById("validateButton").onclick = () => {
            let file = document.getElementById("fileInput").files[0];
            let data = new FormData();
            data.append('file', file);
            data.append('user', 'webapp');
            fetch("/validate", { method: 'POST', body: data });
        }
    </script>
</body>
</html>
