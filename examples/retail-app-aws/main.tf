# module "webFrontend" {
#   source        = "../../modules/static-website/aws"
#   content_path  = "./frontend"
#   content_index = "index.html"

#   template_values = {
#     apiUrl = "${module.productsApi.url}"
#   }
# }

# module "productsApi" {
#   source = "../../modules/rest-api/aws"

#   name = "productsApi"

#   routes = [
#     {
#       path     = "/products"
#       method   = "post"
#       function = "${module.createProduct.endpoint}"
#       cors     = true
#     },
#     {
#       path     = "/{id}"
#       method   = "get"
#       function = "${module.getProduct.endpoint}"
#       cors     = true
#     },
#     {
#       path     = "/catalog/{...categories}"
#       method   = "post"
#       function = "${module.listProduct.endpoint}"
#       cors     = true
#     },
#   ]
# }

module "deploymentsBucket" {
  source = "../../modules/deployment/aws"
}

module "createProduct" {
  source    = "../../modules/function/aws"
  bucket    = "${module.deploymentsBucket.name}"
  name      = "createProduct"
  handler   = "products.create"
  code_path = "./code"

  # env = {
  #   productTableName = "${module.productsDb.tables.products.name}"
  # }
}

module "getProduct" {
  source    = "../../modules/function/aws"
  bucket    = "${module.deploymentsBucket.name}"
  name      = "getProduct"
  handler   = "products.get"
  code_path = "./code"

  # env = {
  #   productTableName = "${module.productsDb.tables.products.name}"
  # }
}

module "listProduct" {
  source    = "../../modules/function/aws"
  bucket    = "${module.deploymentsBucket.name}"
  name      = "listProduct"
  handler   = "products.list"
  code_path = "./code"

  # env = {
  #   productTableName = "${module.productsDb.tables.products.name}"
  # }
}

# module "productsDb" {
#   source = "../../modules/nosql-db/aws"


#   # tables = {
#   #   products = {
#   #     name = "products"


#   #     schema = {
#   #       id          = "number"
#   #       name        = "string"
#   #       description = "string"
#   #       price       = "number"
#   #     }


#   #     indexes = [
#   #       {
#   #         name    = "ProductIdIndex"
#   #         hashKey = "id"
#   #       },
#   #     ]


#   #     timestamps = true
#   #   }
#   # }
# }

