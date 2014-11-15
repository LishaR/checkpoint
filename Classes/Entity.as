package  {
	
	public class Entity {
		private var entityType:String;
		
		public function Entity(newEntityType:String) {
			entityType = newEntityType;
		}
		
		public function getEntityType():String {
			return entityType;
		}
	}
	
}
