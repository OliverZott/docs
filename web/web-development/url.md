# URL – Structure, Function, and Ports

A **Uniform Resource Locator (URL)** is the address used to access resources on the internet. It specifies where a resource is located and how it can be retrieved.

## How a URL Works

When you enter a URL in your browser, several steps occur:

1. **DNS Lookup** – The domain name in the URL is translated into an IP address.
2. **Request to Server** – The browser sends an HTTP request to the appropriate web server.
3. **Server Response** – The server processes the request and responds with the requested resource (e.g., a web page or file).
4. **Rendering in Browser** – The browser displays the returned resource.

## Parts of a URL

https://example.com:8080/path/to/resource?query=value#fragment

| **Component**      | **Example**          | **Description** |
|--------------------|----------------------|----------------|
| **Scheme**        | `https://`            | Defines the protocol (HTTP, HTTPS, FTP, etc.). |
| **Domain**        | `example.com`         | The hostname or IP address of the server. |
| **Port**          | `:3000`               | Specifies the port for communication (optional if standard). |
| **Path**          | `/path/to/resource`   | Defines the resource location on the server. |
| **Query**         | `?query=value`        | Passes additional parameters to the request. |
| **Fragment**      | `#fragment`           | Points to a specific section within the resource. |

## 🔎 Why Do Some Ports Appear in URLs (e.g., `:3000`)?

When you visit a URL like `https://example.com`, the browser assumes the **default port**:

- `http://example.com` **defaults to port 80**.
- `https://example.com` **defaults to port 443**.

However, when using a **non-standard port**, it must be explicitly included:

- `https://example.com:3000` → Uses port `3000`, not the default `443`.

Ports appear **before the resource path** but after the domain because they are part of the network address, telling the browser which service to access.

## 🚀 Common Standard Ports

Here are frequently used **standard ports** across different services:

| **Port**  | **Service**          |
|----------|----------------------|
| `80`     | HTTP (Web) |
| `443`    | HTTPS (Secure Web) |
| `21`     | FTP (File Transfers) |
| `22`     | SSH (Secure Shell) |
| `25`     | SMTP (Email Sending) |
| `53`     | DNS (Domain Name Resolution) |
| `3306`   | MySQL Database |
| `5432`   | PostgreSQL Database |
| `27017`  | MongoDB Database |
| `8080`   | Alternative HTTP Port |
| `3000`   | Common for Local Dev Servers |
| `6379`   | Redis Database |

## 🔒 Reserved System Ports on Linux & Windows

Operating systems **reserve certain ports** for system services to prevent conflicts.

### **Common Reserved Ports**

- **Linux** reserves **ports 0–1023** for privileged services.
- **Windows** has reserved ports for system processes, like:
  - **135** – Windows RPC
  - **445** – SMB (file sharing)
  - **3389** – RDP (Remote Desktop)

To check reserved ports, use:

```bash
cat /etc/services  # Linux system port listings
netstat -ano       # Windows active connections
