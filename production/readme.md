Production OCR

#### Pre-Reqs
- Kuberentes Deployed
- Kubernetes Minions (worker nodes) deployed
- Minions configured with
  - cifs-utils
  - nfs-common
  - active directory (sssd heimdal-clients mskutil)
  - SMB Drivers for k8s (https://github.com/kubernetes-csi/csi-driver-smb)

#### Storage
- PV - Deployment creates a PV to a share where OCR files will be stored and processed
- PVC - Deployments creates a PVC for the Pods from the perscribed PV

#### Container runtime
- This is ran as a stateful set so the container names stay consistant and the naming convention stays consistant for processing the SMB share for manageability and workflow (at this point in time)
- Tesseract-PWSH container is built from this repo.  each time the git repo is updated, the container will automatically be updated and tagged "latest" version
- Container will start, mount PV/PVC to /OCR folder
- the POD contains the command to start the powerShell loop script for OCR processing.  This script gets the "hostname" of the container, and checks in /OCR to see if there is a folder with the same name as the host, if not it will create the folder, then Set-Location to that folder that is the same name as the hostname and will run the OCR loop


#### Docker file
- docker file contains the build process to pull the Tesseract container from docker hub, install powershell, and copy production scripts folder to ./scripts

PowerShell Dockerfile contents came from Microsoft PowerShell-Docker GIThub Repo
https://github.com/PowerShell/PowerShell-Docker

https://github.com/PowerShell/PowerShell-Docker/blob/master/release/stable/ubuntu18.04/docker/Dockerfile


to deploy the OCR stateful set use the following command   
```kubeclt apply -f ocr-loop-ps1-all-statefulset.yaml``` 

