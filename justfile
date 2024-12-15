import? 'just/base.just'
import? 'just/terraform.just'

project := "dungeons-and-llamas"
infraDir := "infra/modules/aws/"
env := "dev"
cluster := "fomiller-cluster"

fetch:
    curl https://raw.githubusercontent.com/Fomiller/justfiles/refs/heads/main/base.just > just/base.just
    curl https://raw.githubusercontent.com/Fomiller/justfiles/refs/heads/main/terraform.just > just/terraform.just
    curl https://raw.githubusercontent.com/Fomiller/justfiles/refs/heads/main/k8s.just > just/k8s.just

################################
######### PROJECT CMDS #########
################################
