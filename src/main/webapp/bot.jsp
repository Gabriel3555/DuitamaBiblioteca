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
        botId: "b419c76c-1bf2-400b-9f74-8abab341ff5f",
        configuration: {
            botName: "Maryuri Asistant",
            botAvatar: "https://files.bpcontent.cloud/2025/04/16/17/20250416171815-XQN5FUVO.jpeg",
            color: "#5eb1ef",
            variant: "soft",
            themeMode: "dark",
            fontFamily: "inter",
            radius: 1
        },
        clientId: "285fcaa0-dcca-481b-af3a-fc6b43ba72de",
        selector: "#webchat"
    });
</script>
</body>
</html>
