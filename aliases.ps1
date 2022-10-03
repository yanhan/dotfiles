# Copy and paste the contents of this file to the file returned by running
# the command `echo $profile` on Powershell
set-alias c curl
set-alias g git
set-alias k kubectl
set-alias kctx kubectx
set-alias kns kubens
set-alias s ssh
set-alias tf terraform
set-alias vim nvim
set-alias v vim

function ga {
  g add $args
}

function gb {
  g branch $args
}

function gca {
  g commit -a $args
}

function gcam {
  g commit --amend
}

function gcas {
  gca -s $args
}

function gco {
  g checkout $args
}

function gcs {
  g commit -s $args
}

function gd {
  g diff $args
}

function gfo {
  git fetch origin $args
}

function gg {
  git grep $args
}

function ggn {
  ggn -n $args
}

function gl {
  g log $args
}

function gl1 {
  gl -1 $args
}

function glp {
  gl -p $args
}

function glp1 {
  glp -1 $args
}

function gls {
  gl --stat $args
}

function gls1 {
  gls -1 $args
}

function gmain {
  g merge --ff-only origin/main $args
}

function gmo {
  g merge --ff-only origin/master $args
}

function gp {
  g push $args
}

function gpom {
  gp origin master $args
}

function grbc {
  g rebase --continue $args
}

function grbi {
  g rebase -i $args
}

function grh {
  g reset --hard $args
}

function grhh {
  grh HEAD $args
}

function grpt {
  g rev-parse --show-toplevel $args
}

function gs {
  g status $args
}

function ka {
  k apply $args
}

function kaf {
  ka -f $args
}

function kc {
  k config $args
}

function kcc {
  kc current-context $args
}

function kcns {
  k config view -o jsonpath='{..namespace}' $args
}

function kcu {
  kc use-context $args
}

function kd {
  k delete $args
}

function kdes {
  k describe $args
}

function kdf {
  kd -f $args
}

function kg {
  k get $args
}

function kl {
  k logs $args
}

function klf {
  kl -f $args
}

function kn {
  kc set-context $(kcc) --namespace $args
}

function knd {
  kn default $args
}

function knks {
  kn kube-system $args
}

function kpf {
  k port-forward $args
}

function krr {
  k rollout restart $args
}

function kx {
  k explain $args
}

function pyd {
  pyenv deactivate $args
}

function scpi {
  scp -i ~/.ssh/config $args
}

function vr {
  v -R $args
}
