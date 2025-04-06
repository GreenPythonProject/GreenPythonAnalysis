/**
 * @RuleID green-python
 * @name List Insert
 * @description Use list append instead of list insert..
 * @kind problem
 * @id python/list-insert
 * @tags security
 * @severity warning
 */


 import semmle.python.dataflow.new.internal.DataFlowPublic
 import python
 
 from MethodCallNode insertCall
 where insertCall.getMethodName() = "insert"
 select insertCall, "Use list append instead of list insert."