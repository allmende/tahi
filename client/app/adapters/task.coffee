`import DS from 'ember-data'`

TaskAdapter = DS.ActiveModelAdapter.extend
  pathForType: (type) ->
    'tasks'

`export default TaskAdapter`

# EMBERCLI TODO - These are engines, no?
# ETahi.AuthorsTaskAdapter = ETahi.TaskAdapter.extend()
# ETahi.TechCheckTaskAdapter= ETahi.TaskAdapter.extend()
# ETahi.RegisterDecisionTaskAdapter= ETahi.TaskAdapter.extend()