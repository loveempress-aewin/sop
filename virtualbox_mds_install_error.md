```bash		================startu================
root@love-VirtualBox:/mnt/AEWIN/MDS_TOOLS/13.5/Linux#   ./mds-13.5-deb-x86_64.run
Verifying archive integrity...  100%   All good.
Uncompressing mds-13.5
Not enough space left in /tmp (0 KB) to decompress ./mds-13.5-deb-x86_64.run (232868 KB)
Consider setting TMPDIR to a directory with more free space.
```

```
git clone --recurse-submodules http://git_user:$ae_git_token@sd20-server.aewin.com/core/lts/dev/evb/ast2500evb.git --branch CB-1937_Beijing_Infosec_v1.0.42I  /mnt/temp/archercity_tmp
```

```
git checkout CB-1937_Beijing_Infosec_v1.0.42I
git pull origin CB-1937_Beijing_Infosec_v1.0.42I
git submodule foreach git checkout CB-1937_Beijing_Infosec_v1.0.42I
git submodule update --recursive

->packages/common/
git lfs fetch --all
```

-------------------------------------------------------------------------------

#  pyenv issus #
```
(.venv) root@bmc-VirtualBox:~# pip install gitpython
The directory '/home/bmc/.cache/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
The directory '/home/bmc/.cache/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
Collecting gitpython
  Downloading https://files.pythonhosted.org/packages/55/60/f884f01eef2a7255875862ec1b12d57d74113ec6e8d9e16c4d254cd6aa3c/GitPython-3.1.20-py3-none-any.whl (178kB)
    57% |██████████████████▍             | 102kB 1.2kB/s eta 0:01:03Exception:
Traceback (most recent call last):
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/urllib3/response.py", line 331, in _error_catcher
    yield
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/urllib3/response.py", line 413, in read
    data = self._fp.read(amt)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/cachecontrol/filewrapper.py", line 62, in read
    data = self.__fp.read(amt)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/http/client.py", line 459, in read
    n = self.readinto(b)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/http/client.py", line 503, in readinto
    n = self.fp.readinto(b)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/socket.py", line 586, in readinto
    return self._sock.recv_into(b)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/ssl.py", line 1012, in recv_into
    return self.read(nbytes, buffer)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/ssl.py", line 874, in read
    return self._sslobj.read(len, buffer)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/ssl.py", line 631, in read
    v = self._sslobj.read(len, buffer)
socket.timeout: The read operation timed out

During handling of the above exception, another exception occurred:


Traceback (most recent call last):
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/cli/base_command.py", line 143, in main
    status = self.run(options, args)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/commands/install.py", line 318, in run
    resolver.resolve(requirement_set)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/resolve.py", line 102, in resolve
    self._resolve_one(requirement_set, req)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/resolve.py", line 256, in _resolve_one
    abstract_dist = self._get_abstract_dist_for(req_to_install)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/resolve.py", line 209, in _get_abstract_dist_for
    self.require_hashes
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/operations/prepare.py", line 283, in prepare_linked_requirement
    progress_bar=self.progress_bar
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 836, in unpack_url
    progress_bar=progress_bar
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 673, in unpack_http_url
    progress_bar)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 897, in _download_http_url
    _download_url(resp, link, content_file, hashes, progress_bar)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 617, in _download_url
    hashes.check_against_chunks(downloaded_chunks)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/utils/hashes.py", line 48, in check_against_chunks
    for chunk in chunks:
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 585, in written_chunks
    for chunk in chunks:
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/utils/ui.py", line 159, in iter
    for x in it:
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_internal/download.py", line 574, in resp_read
    decode_content=False):
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/urllib3/response.py", line 465, in stream
    data = self.read(amt=amt, decode_content=decode_content)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/urllib3/response.py", line 430, in read
    raise IncompleteRead(self._fp_bytes_read, self.length_remaining)
  File "/home/bmc/.pyenv/versions/3.6.10/lib/python3.6/contextlib.py", line 99, in __exit__
    self.gen.throw(type, value, traceback)
  File "/home/bmc/.pyenv/versions/3.6.10/envs/.venv/lib/python3.6/site-packages/pip/_vendor/urllib3/response.py", line 336, in _error_catcher
    raise ReadTimeoutError(self._pool, None, 'Read timed out.')
pip._vendor.urllib3.exceptions.ReadTimeoutError: HTTPSConnectionPool(host='files.pythonhosted.org', port=443): Read timed out.
You are using pip version 18.1, however version 21.3.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```

### solution:  ###
the user need to change:
(didnt use root )

and
[ref-solution](https://stackoverflow.com/questions/43298872/how-to-solve-readtimeouterror-httpsconnectionpoolhost-pypi-python-org-port)
`sudo pip install --default-timeout=100 future`
