infraDir := "infra/modules/aws"
env := 'dev'

clean:
    find . -name "_.*.gen.tf" -type f | xargs -r rm -rv
    find . -name ".terraform.lock.hcl" -type f | xargs -r rm -rv
    find . -name ".terraform" -type d | xargs -r rm -rv
    find . -name ".terragrunt-cache" -type d | xargs -r rm -rv
    
login env=env:
    assume-role login -p {{env}}Terraform

output-module-groups:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt output-module-groups \
    --terragrunt-working-dir {{infraDir}}

import dir tf_resource aws_resource:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt import \
    {{tf_resource}} {{aws_resource}} \
    --terragrunt-working-dir {{infraDir}}/{{dir}}
    
init dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt init \
    --terragrunt-working-dir {{infraDir}}/{{dir}} \
    -reconfigure
    
init-all:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt run-all init \
    --terragrunt-working-dir {{infraDir}}

validate dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt validate \
    --terragrunt-working-dir {{infraDir}}/{{dir}}

validate-all:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt validate \
    --terragrunt-working-dir {{infraDir}}
    
plan dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt plan \
    --terragrunt-working-dir {{infraDir}}/{{dir}}

plan-all:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt run-all \
    plan --terragrunt-working-dir {{infraDir}}

state-list dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt state list \
    --terragrunt-working-dir {{infraDir}}/{{dir}}

output dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt output \
    --terragrunt-working-dir {{infraDir}}/{{dir}}
    
apply dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt apply \
    --terragrunt-working-dir {{infraDir}}/{{dir}}

apply-all:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt run-all apply \
    --terragrunt-working-dir {{infraDir}} \
    --terragrunt-non-interactive

destroy dir:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt destroy \
    --terragrunt-working-dir {{infraDir}}/{{dir}}
    
destroy-all:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt run-all \
    destroy --terragrunt-working-dir {{infraDir}}
    
destroy-target dir target:
    doppler run \
    --name-transformer tf-var  \
    -- terragrunt destroy \
    --target {{target }} \
    --terragrunt-working-dir {{infraDir}}/{{dir}}

fmt:
    doppler run \
    --name-transformer tf-var  \
    -- terraform fmt \
    --recursive

update-kubeconfig:
    doppler run -- aws eks update-kubeconfig --name fomiller-cluster

@init-module dir:
    mkdir -p {{infraDir}}/{{dir}}/env-config/us-east-1
    
    touch {{infraDir}}/{{dir}}/env-config/common.tfvars
    touch {{infraDir}}/{{dir}}/env-config/us-east-1/common.tfvars
    touch {{infraDir}}/{{dir}}/env-config/us-east-1/dev.tfvars
    touch {{infraDir}}/{{dir}}/env-config/us-east-1/prod.tfvars
    touch {{infraDir}}/{{dir}}/_outputs.tf
    touch {{infraDir}}/{{dir}}/_inputs.tf
    touch {{infraDir}}/{{dir}}/_data.tf
    touch {{infraDir}}/{{dir}}/_variables.tf
    touch {{infraDir}}/{{dir}}/{{dir}}.tf
    touch {{infraDir}}/{{dir}}/main.tf
    touch {{infraDir}}/{{dir}}/terragrunt.hcl
    
    echo 'asset_name = "{{dir}}"' >> {{infraDir}}/{{dir}}/env-config/common.tfvars
    echo 'locals {}' >> {{infraDir}}/{{dir}}/main.tf
    echo 'environment = "dev"' > {{infraDir}}/{{dir}}/env-config/us-east-1/dev.tfvars
    echo 'environment = "prod"' > {{infraDir}}/{{dir}}/env-config/us-east-1/prod.tfvars
    echo -e 'include "root" {\n\
    \tpath = find_in_parent_folders()\n\
    }' > {{infraDir}}/{{dir}}/terragrunt.hcl
    @# {{infraDir}}/{{dir}} created.

