<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prueba Botpress</title>
    <script src="https://cdn.botpress.cloud/webchat/v2.3/inject.js"></script>
</head>
<body>
<div id="webchat" style="width: 500px; height: 500px"></div>
<script>
    window.botpress.init({
        botId: "a726fe13-2ba2-44b7-9c1f-6f1b4376a475",
        configuration: {
            botName: "Daniela Bibliotecaria",
            botAvatar: "https://files.bpcontent.cloud/2025/04/16/03/20250416033327-EW92Q078.png",
            color: "#5eb1ef",
            variant: "soft",
            themeMode: "dark",
            fontFamily: "inter",
            radius: 1
        },
        clientId: "f2273056-4853-4ba3-ba59-d3c81aa0d4a7",
        selector: "#webchat"
    });
</script>
</body>
</html>