# serverless.tf

This is an **experiment**.

Inspired by [Serverless Components](https://github.com/serverless/components), but uses [Terraform](https://terraform.io) for provisioning.

Note: (so far it's only Terraform modules, maybe will include in the future custom Terraform plugins to handle specific tasks, like local simulation or packaging)

## Why

Using Serverless Framework, if you need something more sofisticated like DynamoDB tables or Route 53 domains, you need to use [Resources](https://serverless.com/framework/docs/providers/aws/guide/resources/), that is just CloudFormation templates with all that verbosity.

## Advantages

- does not need Node.js, nor focus on Node.js functions/apps as first-class citizens: bring your own stack;
- support more than AWS, with the same "interface" (module + variables). See [examples](./examples/); Many kinds of resources from different providers are supported;
- just one syntax to learn, reuse it when defining "components" (optinionated modules) or custom [resources](https://www.terraform.io/intro/getting-started/dependencies.html#assigning-an-elastic-ip);
- built-in support for stages: See [workspaces](https://www.terraform.io/docs/state/workspaces.html);
- plan and understand each change with `terraform plan` and deploy with `terraform apply` (always incremental deployments);
- support for pretty much everything Terraform supports.

## Disvantages

- no boilerplate or generators (yet);
- no support for simulation locally or remotely (not missing serverless components);
- no support for log tailing or metrics viewing;

## Comparison with serverless framework cli

|    serverless cli    |        terraform        |
| -------------------- | ----------------------- |
| create               | -                       |
| deploy               | apply                   |
| deploy function      | apply ¹                 |
| deploy list          | show ²                  |
| deploy list function | show ²                  |
| info                 | show ²                  |
| install              | get                     |
| invoke               | -                       |
| invoke local         | -                       |
| logs                 | -                       |
| metrics              | -                       |
| package              | plan                    |
| plugin...            | init                    |
| remove               | edit + plan + apply     |
| rollback             | checkout + plan + apply |
| rollback function    | checkout + plan + apply |

¹ Already incremental deploy
² Very verbose
