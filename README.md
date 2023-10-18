# Airbyte Provider of Terraform (Slack -> S3)

Le but de ce POC est principalement de manipuler le nouveau provider Airbyte de Terraform. Pour cela, vous disposez d'un fichier airbyte.tf qui permet de générer une source (Slack), une destination (S3) et une connexion entre les deux.

![pipeline logo](assets/pipeline.png)

## Pré-requis
Pour utiliser ce POC, il faudra avoir:
- Git
- Terraform (1.5.7)
- Docker/Rancher

## Infos à renseigner
Pour utiliser ce projet, vous devrez renseigner un certain nombre d'informations.
- workspace_id: trouvable dans l'URL de votre client Airbyte lorsque vous le lancez, entre les champs /workspaces/ et /connections/
- Access Key (+ Secret Key): créer un User IAM sur AWS et générer lui une Access Key (voir la doc d'Airbyte pour connaitre les policies à attacher)
- API Token de Slack: j'ai suivi ces instructions pour le générer: https://airbyte.com/tutorials/build-a-slack-activity-dashboard-with-apache-superset
- Créer un bucket S3 destiné à recevoir les messages de Slack ainsi qu'un dossier "csv" à l'intérieur (voir explications dans variable.tf)


## Setup Airbyte

J'utilise Airbyte en local. Il faut cloner le repo d'Airbyte et runner l'image Docker fournie:
```sh
# Dans le terminal
git clone https://github.com/airbytehq/airbyte.git
cd airbyte

# La première fois
./run-ab-platform.sh
# Sinon (up pour lancer, stop pour arrêter)
docker-compose up
docker-compose stop
```
Tout se passe ici ensuite: http://localhost:8000
Par défaut, il faudra entrer "airbyte" et "password" pour se connecter.


## Setup Terraform
Pour lancer le projet et créer les ressources Terraform:
```terraform
cd terraform
terraform init
terraform plan --out plan.cache
terraform apply "plan.cache"
```


## Notes
Pour relancer la récupération des messages sur Slack par Airbyte, il est préférable de détruire l'infrastructure et la reconstruire:
```terraform
terraform destroy
terraform plan --out plan.cache
terraform apply "plan.cache"
```
Pour rappel, aucun Bucket S3 n'est généré ici, vous devez en créer un à la main. Aussi, vous devez créer un dossier qui contiendra les données provenant de la source. Par défaut, le nom de ce dossier est "csv" mais vous pouvez modifier cette valeur dans variable.tf