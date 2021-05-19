# mongodb学习总结

为mongodb文档应用验证规则

validationLevel

- strict
- moderate

假设有如下两条数据:

```shell
db.contacts.insert([
   { "_id": 1, "name": "Anne", "phone": "+1 555 123 456", "city": "London", "status": "Complete" },
   { "_id": 2, "name": "Ivan", "city": "Vancouver" }
])
```

对该文档进行规则验证:

```shell
db.runCommand( {
   collMod: "contacts",
   validator: { $jsonSchema: {
      bsonType: "object",
      required: [ "phone", "name" ],
      properties: {
         phone: {
            bsonType: "string",
            description: "must be a string and is required"
         },
         name: {
            bsonType: "string",
            description: "must be a string and is required"
         }
      }
   } },
   validationLevel: "moderate"
} )
```

应用了上述的规则之后:

- 如果试图更新 `_id`为1, MongoDB将应用验证规则，因为现有文档与条件匹配。

- 相反，MongoDB不会对`_id`为2的文档应用验证规则，因为它不符合验证规则。





