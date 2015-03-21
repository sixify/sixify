from subprocess import (PIPE, Popen)


def invoke(command, _in=None):
    '''
    Invoke command as a new system process and return its output.
    '''
    process = Popen(command, stdin=PIPE, stdout=PIPE, stderr=PIPE, shell=True,
                    executable='/bin/bash')
    if _in is not None:
        return process.communicate(input=_in)
    stdoutdata = process.stdout.read()
    stderrdata = process.stderr.read()
    return (stdoutdata, stderrdata)
