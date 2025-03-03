/**
 * @id @id green-python
 * @name List Append
 * @description List Append found.
 * @kind problem
 * @tags print, builtin
 * @severity warning
 */


 import semmle.python.dataflow.new.internal.DataFlowPublic
 import python
 
 from MethodCallNode insertCall
 where insertCall.getMethodName() = "append"
 select insertCall, "List Append Found"