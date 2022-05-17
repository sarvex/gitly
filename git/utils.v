module git

import regex
import os

pub fn get_repository_primary_branch(path string) string {
	git_result := os.execute('git -C $path symbolic-ref HEAD')
	git_exit_code := git_result.exit_code
	git_output := git_result.output.trim(' \n')

	if git_exit_code != 0 {
		return ''
	}

	return get_branch_name_from_reference(git_output)
}

fn get_branch_name_from_reference(value string) string {
	branch_query := r'refs/heads/(.*)'
	mut re := regex.regex_opt(branch_query) or { panic(err) }
	re.match_string(value)

	return re.get_group_by_id(value, 0)
}
