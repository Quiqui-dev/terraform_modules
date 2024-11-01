#! /bin/bash


print_help () {
    echo ""
    echo "Usage: sh $0 [provider] [module_name]"
    echo ""
    echo "Provider Options:"
    echo "  azure   Create a new module with the name provided from the base-azure-module"
    echo "  aws     Create a new module with the name provided from the base-aws-module"
    echo "  gcp     Create a new module with the name provided from the base-gcp-module"
}


create_module () {

    if [ ! -d "$1/$2" ]; then
        mkdir "$1/$2"
    fi

    touch "$1/$2/variables.tf"
    touch "$1/$2/$2.tf"
}

azure_module () {

    create_module "Azure" $1

    cp "base-module-azure/providers.tf" "Azure/$1/providers.tf"
}


aws_module () {

    create_module "AWS" $1

    cp "base-module-aws/providers.tf" "AWS/$1/providers.tf"
}

gcp_module () {

    create_module "GCP" $1

    cp "base-module-gcp/providers.tf" "GCP/$1/providers.tf"
}


case $1 in
    "azure")
        azure_module "$2"
    ;;
    "aws")
        aws_module "$2"
    ;;
    "gcp")
        gcp_module "$2"
    ;;
    *)
        echo ""
        echo "Unknown option: $1"
        print_help
        echo ""
        exit 1
        ;;
esac