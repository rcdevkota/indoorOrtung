<?php
header('Content-Type: application/json');
$ziel=null;

class RutenPunkt {
	private float $minCost;
	private int $id;
	private array $pos;
	private bool $traversable;
	
	private ?RutenPunkt $parent;

	function __construct(int $id,?RutenPunkt $parent){
		$db = new PDO('mysql:host=localhost;dbname=indoor_ortung', 'root', '');
		$stmt = $db->prepare( "SELECT id,longitude,latitude,level,traversable FROM waypoints WHERE id=?");
		$stmt->execute([$id]);
		
		foreach ($stmt as $row) {
			$this->pos= array(
				"x" => floatval($row["longitude"]), 
				"y" => floatval( $row["latitude"]), 
				"l" => floatval($row["level"]));
			$this->traversable = $row["traversable"];
			$this->id=$row["id"];
			
		}
		$this->parent=$parent;

		if(!is_null($GLOBALS["ziel"])){
			$this->minCost=$this->getCost() + $this->getAname();
		}		
	}

	function getCost(){
		if(is_null($this->parent)){
			return 0;
		}
		return $this->distans($this->parent)+$this->parent->getCost();
	}
	
	function getId(){
		return $this->id;
	}

	function getPos(){
		return $this->pos;
	}

	function getAname(){
		return $this->distans($GLOBALS["ziel"]);
	}

	function toAut(){
		
		$temp =$this->pos;
		array_push($temp, $this->id);

		return $temp;
	}

	function getPfart(){
		if(is_null($this->parent)){


			return array($this->toAut());


		}
		$temp=$this->parent->getPfart();
		array_push($temp, $this->toAut());
		return $temp;
	}

	function distans(RutenPunkt $in){
		return sqrt(
				 pow($this->pos["x"]-$in->getPos()["x"],2)
				+pow($this->pos["y"]-$in->getPos()["y"],2)
			)
			+abs($this->pos["l"]-$in->getPos()["l"])
			;
	}

	function __toString(){
		return "id:" . $this->id;
	}
}

$startingTarget= startingTarget();
if($startingTarget==null){
	http_response_code('400');
	echo http_response_code();
	exit;
}

function startingTarget(){
	if(isset($_GET['sId']) && isset($_GET['tId'])){
		return array('start'=>$_GET['sId'], 'target'=> $_GET['tId']);
	}else{
		return null;
	}
}

$ziel = new RutenPunkt($startingTarget['start'],null);
$start = new RutenPunkt($startingTarget['target'],null);



$heap = new SplMinHeap();
$heap->insert($start);


$test=0;

while($heap->current()->getId()!=$ziel->getId()){

	getNachbern($heap->extract() ,$heap);

	$test++;
	if($test>100){
		echo "entlos \n";
		break;
	}
}
echo json_encode($heap->current()->getPfart());



function getNachbern(RutenPunkt $alt ,SplMinHeap $heap){
	$db = new PDO('mysql:host=localhost;dbname=indoor_ortung', 'root', '');
	$stmt = $db->prepare( "SELECT pointsA as p FROM ways  WHERE pointsB=? union SELECT pointsB as p FROM ways WHERE pointsA=?");
	$stmt->execute([$alt->getId(),$alt->getId()]);
	foreach ($stmt as $row) {
			$heap->insert(new RutenPunkt($row["p"],$alt));
	
	}

}



?>