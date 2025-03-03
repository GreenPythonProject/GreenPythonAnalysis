/**
 * @id py/examples/insert
 * @name List Insert
 * @description List Append found.
 * @kind problem
 * @tags print, builtin
 * @severity warning
 */


 import semmle.python.dataflow.new.internal.DataFlowPublic
 import python
 
 from MethodCallNode insertCall
 where insertCall.getMethodName() = "insert"
 select insertCall, "List Append Found"