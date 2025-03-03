/**
 * @id py/examples/insert
 * @name List Insert
 * @description List Insert found.
 * @tags print, builtin
 */


import semmle.python.dataflow.new.internal.DataFlowPublic
import python

from MethodCallNode insertCall, File file
where insertCall.getMethodName() = "insert"
select insertCall, "list insert found",
       file.getAbsolutePath(),
       insertCall.getLocation().getStartLine(),
       insertCall.getLocation().getStartColumn()