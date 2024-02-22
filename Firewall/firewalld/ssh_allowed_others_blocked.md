## Blocking all traffic except SSH with firewalld on Ubuntu

Here's how to configure firewalld on Ubuntu to block all traffic except SSH:

**Method 1: Using default drop policy and allow rule:**

1. **Set default drop policy:**
   ```
   sudo firewall-cmd --permanent --set-default-zone=block
   ```
   This sets the default behavior of the firewall to "drop" all incoming traffic.

2. **Allow SSH:**
   ```
   sudo firewall-cmd --permanent --add-port=22/tcp
   ```
   This allows incoming TCP connections on port 22, used for SSH access.

3. **Reload firewall:**
   ```
   sudo firewall-cmd --reload
   ```

**Method 2: Using rich rule for explicit allow:**

1. **Create a rich rule:**
   ```
   sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="0.0.0.0/0" service="ssh" accept'
   ```
   This rule explicitly allows all incoming SSH connections (replace `0.0.0.0/0` with your specific IP if desired).

2. **Reload firewall:**
   ```
   sudo firewall-cmd --reload
   ```

**Important notes:**

* Before applying these changes, ensure you can still connect to your server via SSH after blocking other traffic. Test it carefully!
* Consider using a dynamic DNS service if your IP address changes frequently.
* Remember to make changes permanent with `--permanent` and reload the firewall afterwards with `--reload`.
* This configuration blocks all outbound traffic as well. If you need specific services accessible, add additional allow rules accordingly.

**Additional tips:**

* Use strong SSH passwords and consider using SSH keys for authentication instead.
* Keep your Ubuntu system and SSH server updated to patch vulnerabilities.

Choose the method that best suits your understanding and preference. Both achieve the same goal of allowing only SSH traffic. Remember to be cautious and test thoroughly before applying changes to your firewall.
