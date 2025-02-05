# Deploying a rest api

To make your API accessible from outside your local machine, you'll need to expose your local server to the internet. Here are the steps to do that:

1. Find your local IP address: You'll need to know your local IP address to allow external access. You can find this by running ipconfig (Windows) or ifconfig (Linux/Mac) in your terminal.

2. Open the port on your router: You'll need to forward the port on your router to your local machine. This usually involves logging into your router's admin page, finding the port forwarding section, and setting it to forward requests from an external port (e.g., 8080) to your local IP address on the same port1.

3. Update your server to listen on your local IP address: Change your server code to listen on your local IP address instead of localhost. For example:

    ```js
    typescript
    const express = require('express');
    const app = express();
    const port = process.env.PORT || 8080;
    app.listen(port, 'YOUR_LOCAL_IP_ADDRESS', () => {
        console.log(`Server is running on http://YOUR_LOCAL_IP_ADDRESS:${port}`);
    });
    ```

4. Check your firewall settings: Ensure that your firewall allows incoming connections on the port you're using (e.g., 8080).

5. Test external access: Try accessing your API from another device using your public IP address and the port you forwarded (e.g., http://YOUR_PUBLIC_IP_ADDRESS:8080).
