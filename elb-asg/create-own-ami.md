# Creating a Custom AMI to Serve a Node.js Server

## 1. Install Node.js

```bash
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs
```

---

## 2. Create the Application Directory & `app.js`

We will store the app in `/opt/node-server` so that systemd can reliably locate it.

```bash
sudo mkdir -p /opt/node-server
sudo nano /opt/node-server/app.js
```

Paste the following code into `app.js`:

```javascript
const http = require('http');
const os = require('os');

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    const ip = Object.values(os.networkInterfaces())
      .flat()
      .filter(addr => addr.family === 'IPv4' && !addr.internal)[0]?.address || 'unknown';
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.end(`Hello from IP: ${ip}`);
  } else {
    res.writeHead(404, {'Content-Type': 'text/plain'});
    res.end('Not Found');
  }
});

server.listen(80, () => {
  console.log('Server running on port 80');
});
```

Save and exit the editor.

---

## 3. Set Permissions

Make sure the `ec2-user` owns the application directory and its contents:

```bash
sudo chown -R ec2-user:ec2-user /opt/node-server
```

---

## 4. Allow Node.js to Bind to Port 80 Without Root Privileges

```bash
sudo setcap 'cap_net_bind_service=+ep' /usr/bin/node
```

---

## 5. Create the systemd Service

Create the service file:

```bash
sudo nano /etc/systemd/system/node-server.service
```

Paste the following content:

```ini
[Unit]
Description=Simple Node.js HTTP Server
After=network.target

[Service]
ExecStart=/usr/bin/node /opt/node-server/app.js
Restart=always
User=ec2-user
Group=ec2-user
Environment=PATH=/usr/bin:/usr/local/bin
Environment=NODE_ENV=production
WorkingDirectory=/opt/node-server

[Install]
WantedBy=multi-user.target
```

Save and exit.

---

## 6. Enable and Start the Service

```bash
sudo systemctl daemon-reload
sudo systemctl enable node-server
sudo systemctl start node-server
```
