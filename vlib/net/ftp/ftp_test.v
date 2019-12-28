module main

import net.ftp

fn test_all() {
	mut ftp := ftp.new()
	defer {
		ftp.close()
	}

	assert ftp.connect('ftp.redhat.com')
	assert ftp.login('ftp','ftp')

	pwd := ftp.pwd()

	ftp.cd('/')
	dir_list1 := ftp.dir() or {
		assert false
		return
	}
	assert dir_list1.len > 0

	ftp.cd('/suse/linux/enterprise/11Server/en/SAT-TOOLS/SRPMS/')
	dir_list2 := ftp.dir() or {
		assert false
		return
	}
	assert dir_list2.len > 0

	blob := ftp.get('katello-host-tools-3.3.5-8.sles11_4sat.src.rpm') or {
		assert false
		return
	}
	assert blob.len > 0
}