package  {
	import Box2D.Dynamics.b2Body;
	
	public class Entity {
		private var entityType:String;
		protected var body:b2Body;
		
		public function Entity(newEntityType:String, newBody:b2Body=null) {
			entityType = newEntityType;
		}
		
		public function getEntityType():String {
			return entityType;
		}
		
		public function getBody():b2Body {
			return body;
		}
		
		
		
	}
	
}
