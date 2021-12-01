$State = @{
  '{NUMLOCK}' = $false
  '{CAPSLOCK}' = $false
  '{SCROLLLOCK}' = $false
}

$Kb = (New-Object -c WScript.Shell)

function SetKey($Key, $On) {
  if ($On) {
    if (-Not $State[$Key]) {
      $Kb.SendKeys($Key)
      $State[$Key] = $true
    }

  } else {
    if ($State[$Key]) {
      $Kb.SendKeys($Key)
      $State[$Key] = $false
    }
  }
}

# Frame
function F($Num, $Caps, $Scroll, $Duration) {
  SetKey '{NUMLOCK}' $Num
  SetKey '{CAPSLOCK}' $Caps
  SetKey '{SCROLLLOCK}' $Scroll
  
  sleep -m $Duration
}

function ScrollR1($Duration) {
  F 0 0 0 $Duration
  F 1 0 0 $Duration
  F 0 1 0 $Duration
  F 0 0 1 $Duration
}

function ScrollR2($Duration) {
  F 0 0 0 $Duration
  F 1 0 0 $Duration
  F 1 1 0 $Duration
  F 0 1 1 $Duration
  F 0 0 1 $Duration
}

function ScrollR3($Duration) {
  F 0 0 0 $Duration
  F 1 0 0 $Duration
  F 1 1 0 $Duration
  F 1 1 1 $Duration
  F 0 1 1 $Duration
  F 0 0 1 $Duration
}

function ScrollL1($Duration) {
  F 0 0 0 $Duration
  F 0 0 1 $Duration
  F 0 1 0 $Duration
  F 1 0 0 $Duration
}

function Bounce($Duration) {
  F 1 0 0 $Duration
  F 0 1 0 $Duration
  F 0 0 1 $Duration
  F 0 1 0 $Duration
}

function BounceOut($Duration) {
  F 0 0 0 $Duration
  F 1 0 0 $Duration
  F 0 1 0 $Duration
  F 0 0 1 $Duration
  F 0 0 0 $Duration
  F 0 0 1 $Duration
  F 0 1 0 $Duration
  F 1 0 0 $Duration
}

function Droplet($Duration) {
  F 0 0 0 ($Duration + 50)
  F 0 1 0 $Duration
  F 0 0 0 ($Duration + 100)
  F 0 1 0 $Duration
  F 1 0 1 ($Duration + 50)
}

function PulseR($Duration) {
  F 0 0 0 ($Duration + 50)
  F 1 0 0 $Duration
  F 1 1 0 $Duration
  F 1 1 1 $Duration
  F 1 1 0 $Duration
  F 1 0 0 $Duration
}

function PulseL($Duration) {
  F 0 0 0 ($Duration + 50)
  F 0 0 1 $Duration
  F 0 1 1 $Duration
  F 1 1 1 $Duration
  F 0 1 1 $Duration
  F 0 0 1 $Duration
}

cls

$Dur = 150

try { for () {

ScrollR1 $Dur
ScrollR2 $Dur
ScrollR3 $Dur
ScrollL1 $Dur
# Bounce $Dur
BounceOut $Dur
Droplet ($Dur + 50)
PulseR ($Dur - 50)
PulseL ($Dur - 50)

}} finally {
  F 0 0 0 0
}
