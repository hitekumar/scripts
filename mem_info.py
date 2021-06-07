#!/usr/bin/env python
# Print memory info of a process (PID)

def _procMemoryGrep(filename, vmkeys):
    size_scale = {'kb': 1024.0, 'mb':1048576.0, 'gb':1073741824.0}
    values = {}

    fd = open(filename)
    try:
        for line in fd:
            for vmkey in vmkeys:
                if vmkey in line:
                    _, size, scale = line.split()
                    scale = size_scale.get(scale.strip().lower(), 1)
                    values[vmkey] = float(size.strip()) * scale
    finally:
        fd.close()

    return values

class MemoryInfo(object):
    _KEYS = [
        'VmPeak',      # peak virtual memory size
        'VmSize',      # total program size
        'VmLck',       # locked memory size
        'VmHWM',       # peak resident set size ("high water mark")
        'VmRSS',       # size of memory portions
        'VmData',      # size of data, stack, and text segments
        'VmStk',       # size of data, stack, and text segments
        'VmExe',       # size of text segment
        'VmLib',       # size of shared library code
        'VmPTE',       # size of page table entries
        'VmSwap',      # size of swap usage (the number of referred swapents)
    ]

    def __init__(self, proc):
        self.pid = proc
        self._status = {}
        self.update()

    def __getitem__(self, key):
        return self._status[key]

    def update(self):
        self._status = _procMemoryGrep('/proc/%d/status' % self.pid, self._KEYS)

def humanSize(size):
    human = ((1 << 80, 'YiB'),
             (1 << 70, 'ZiB'),
             (1 << 60, 'EiB'),
             (1 << 50, 'PiB'),
             (1 << 40, 'TiB'),
             (1 << 30, 'GiB'),
             (1 << 20, 'MiB'),
             (1 << 10, 'KiB'))
    for t, s in human:
        if size >= t:
            return '%.2f %s' % ((size / t), s)
    return '%d bytes' % size


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print 'usage: mem-info <pid>'
        print '       mem-info `pidof init`'
    else:
        mem = MemoryInfo(int(sys.argv[1]))
        print 'peak virtual memory size', humanSize(mem['VmPeak'])
        print 'total program size', humanSize(mem['VmSize'])
        print 'locked memory size', humanSize(mem['VmLck'])
        print 'peak resident set size ("high water mark")', humanSize(mem['VmHWM'])
        print 'size of memory portions', humanSize(mem['VmRSS'])
        print 'size of Data, stack, and text segments', humanSize(mem['VmData'])
        print 'size of data, Stack, and text segments', humanSize(mem['VmStk'])
        print 'size of text segment', humanSize(mem['VmExe'])
        print 'size of shared library code', humanSize(mem['VmLib'])
        print 'size of page table entries', humanSize(mem['VmPTE'])
        print 'size of swap usage (the number of referred swapents)', humanSize(mem['VmSwap'])
