`import DS from 'ember-data'`

Feedback = DS.Model.extend
  remarks: DS.attr 'string'
  referrer: DS.attr 'string'

`export default Feedback`