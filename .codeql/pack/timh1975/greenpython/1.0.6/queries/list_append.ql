/**
 * @id py/examples/insert
 * @name List Append
 * @description List Append found.
 * @kind problem
 * @tags print, builtin
 */


 import semmle.python.dataflow.new.internal.DataFlowPublic
 import python
 
 from MethodCallNode insertCall, File file
 where insertCall.getMethodName() = "append"
 select insertCall, "List Append Found",
        file.getAbsolutePath(),
        insertCall.getLocation().getStartLine(),
        insertCall.getLocation().getStartColumn()