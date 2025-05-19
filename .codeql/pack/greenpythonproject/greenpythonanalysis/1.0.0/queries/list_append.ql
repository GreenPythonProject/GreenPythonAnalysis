/**
 * @id green-python
 * @name List Append
 * @description List Append is more energy efficient than using a list insert.
 * @kind problem
 * @tags security
 * @severity warning
 */


 import semmle.python.dataflow.new.internal.DataFlowPublic
 import python
 
 from MethodCallNode insertCall
 where insertCall.getMethodName() = "append"
 select insertCall, "List Append is more energy efficient than using a list insert."