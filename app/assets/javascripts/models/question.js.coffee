a = DS.attr
ETahi.Question = DS.Model.extend
  ident: a('string')
  question: a('string')
  answer: a('string')
  additionalData: a()
  task: DS.belongsTo('task')
  url: a('string')
  questionAttachment: DS.belongsTo('questionAttachment')
