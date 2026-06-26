# =============================================================================
# Workspace Auto-switch to mise
# =============================================================================
# These wrapper functions automatically use 'mise exec' when inside ~/workspace

node() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- node "$@"
	else
		command node "$@"
	fi
}
npm() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- npm "$@"
	else
		command npm "$@"
	fi
}
npx() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- npx "$@"
	else
		command npx "$@"
	fi
}
go() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- go "$@"
	else
		command go "$@"
	fi
}
python() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- python "$@"
	else
		command python "$@"
	fi
}
python3() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- python3 "$@"
	else
		command python3 "$@"
	fi
}
pip() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- pip "$@"
	else
		command pip "$@"
	fi
}
pip3() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- pip3 "$@"
	else
		command pip3 "$@"
	fi
}
dotnet() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- dotnet "$@"
	else
		command dotnet "$@"
	fi
}
java() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- java "$@"
	else
		command java "$@"
	fi
}
javac() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- javac "$@"
	else
		command javac "$@"
	fi
}
flutter() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- flutter "$@"
	else
		command flutter "$@"
	fi
}
dart() {
	if [[ "$PWD" == "$HOME/workspace"* ]]; then
		mise exec -- dart "$@"
	else
		command dart "$@"
	fi
}
