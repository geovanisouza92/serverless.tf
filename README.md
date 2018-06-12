# serverless.tf

This is an **experiment**.

Inspired by [Serverless Components](https://github.com/serverless/components), but uses [Terraform](https://terraform.io) for provisioning.

Note: (so far it's only Terraform modules, maybe include custom Terraform plugins to handle specific tasks, like local simulation or packaging)

## Why

Using Serverless Framework, if you need something more sofisticated like DynamoDB tables or Route 53 domains, you need to use [Resources](https://serverless.com/framework/docs/providers/aws/guide/resources/), that is just CloudFormation templates with all that verbosity.

## Advantages

- does not need Node.js, nor focus on Node.js functions/apps as first-class citizens: bring your own stack;
- support more than AWS, with the same "interface" (module + variables). See [examples](./examples/); Many kinds of resources from different providers are supported;
- just one syntax to learn, reuse it when defining "components" (optinionated modules) or custom [resources](https://www.terraform.io/intro/getting-started/dependencies.html#assigning-an-elastic-ip);
- built-in support for stages: See [workspaces](https://www.terraform.io/docs/state/workspaces.html);
- plan and understand each change with `terraform plan` and deploy with `terraform apply`;
