enum Quadrant { Division1, Division2, Division3, Division4, Division5, Division6, Division7 }
enum Block {
  Block1, Block2, Block3, Block4, Block5, Block6, Block7, Block8, Block9, Block10,
  Block12, Block13, Block14, Block15, Block16, Block17, Block18, Block19, Block20,
  Block21, Block22, Block23, Block24, ComplejoDeIngenierias, Forum, BloquesExternosAlCampus
}
enum RelationshipWithTheUniversity {
  universitary,
  estudent,
  professor,
  visitor,
}
enum Gender { Male, Female, Otro }
enum EquipmentType {
  APOSITO_OCULAR, APOSITO_PQ, BAJALENGUA, BOLSAS_ROJAS, CATETER, ELECTRODOS,
  GUANTES_DE_LATEX, LANCETA, TIRILLA, MACROGOTERO, SOL_SALINA, TAPABOCA,
  TORUNDA_DE_ALGODON, VENDA_DE_GASA_4_5YD, VENDA_DE_GASA_5_5YD,
  VENDA_ELASTICA_4_5YD, VENDA_ELASTICA_5_5YD
}
enum EquipmentSource { Botiquin, Gabinete, TraumaPolideportivo }
enum Cases { Incendio, Medico, Estructural }
enum DocumetType{  CedulaDeCiudadania, TarjetDeIdentidad, CedulaDeExtranjeria }

enum BloodType { A_POS, O_POS, B_POS, AB_POS, A_NEG, O_NEG, B_NEG, AB_NEG }

// Función getDisplayName para mostrar nombres personalizados

String getDisplayName(dynamic item) {
  if (item is Block) {
    switch (item) {
      case Block.Block1: return "Bloque 1";
      case Block.Block2: return "Bloque 2";
      case Block.Block3: return "Bloque 3";
      case Block.Block4: return "Bloque 4";
      case Block.Block5: return "Bloque 5";
      case Block.Block6: return "Bloque 6";
      case Block.Block7: return "Bloque 7";
      case Block.Block8: return "Bloque 8";
      case Block.Block9: return "Bloque 9";
      case Block.Block10: return "Bloque 10";
      case Block.Block12: return "Bloque 12";
      case Block.Block13: return "Bloque 13";
      case Block.Block14: return "Bloque 14";
      case Block.Block15: return "Bloque 15";
      case Block.Block16: return "Bloque 16";
      case Block.Block17: return "Bloque 17";
      case Block.Block18: return "Bloque 18";
      case Block.Block19: return "Bloque 19";
      case Block.Block20: return "Bloque 20";
      case Block.Block21: return "Bloque 21";
      case Block.Block22: return "Bloque 22";
      case Block.Block23: return "Bloque 23";
      case Block.Block24: return "Bloque 24";
      case Block.ComplejoDeIngenierias: return "Complejo de Ingenierías";
      case Block.Forum: return "Forum";
      case Block.BloquesExternosAlCampus: return "Bloques Externos al Campus";
    }
  } else if (item is Quadrant) {
    switch (item) {
      case Quadrant.Division1: return "División 1";
      case Quadrant.Division2: return "División 2";
      case Quadrant.Division3: return "División 3";
      case Quadrant.Division4: return "División 4";
      case Quadrant.Division5: return "División 5";
      case Quadrant.Division6: return "División 6";
      case Quadrant.Division7: return "División 7";
    }
  } else if (item is Gender) {
    switch (item) {
      case Gender.Male: return "Masculino";
      case Gender.Female: return "Femenino";
      case Gender.Otro: return "Otro";
    }
  } else if (item is EquipmentType) {
    switch (item) {
      case EquipmentType.APOSITO_OCULAR: return "Apósito Ocular";
      case EquipmentType.APOSITO_PQ: return "Apósito PQ";
      case EquipmentType.BAJALENGUA: return "Bajalengua";
      case EquipmentType.BOLSAS_ROJAS: return "Bolsas Rojas";
      case EquipmentType.CATETER: return "Catéter";
      case EquipmentType.ELECTRODOS: return "Electrodos";
      case EquipmentType.GUANTES_DE_LATEX: return "Guantes de Látex";
      case EquipmentType.LANCETA: return "Lanceta";
      case EquipmentType.TIRILLA: return "Tirilla";
      case EquipmentType.MACROGOTERO: return "Macrogotero";
      case EquipmentType.SOL_SALINA: return "Solución Salina";
      case EquipmentType.TAPABOCA: return "Tapaboca";
      case EquipmentType.TORUNDA_DE_ALGODON: return "Torunda de Algodón";
      case EquipmentType.VENDA_DE_GASA_4_5YD: return "Venda de Gasa 4.5YD";
      case EquipmentType.VENDA_DE_GASA_5_5YD: return "Venda de Gasa 5.5YD";
      case EquipmentType.VENDA_ELASTICA_4_5YD: return "Venda Elástica 4.5YD";
      case EquipmentType.VENDA_ELASTICA_5_5YD: return "Venda Elástica 5.5YD";
    }
  } else if (item is EquipmentSource) {
    switch (item) {
      case EquipmentSource.Botiquin: return "Botiquín";
      case EquipmentSource.Gabinete: return "Gabinete";
      case EquipmentSource.TraumaPolideportivo: return "Trauma Polideportivo";
    }
  } else if (item is Cases) {
    switch (item) {
      case Cases.Incendio: return "Incendio";
      case Cases.Medico: return "Médico";
      case Cases.Estructural: return "Estructural";
    }
  } else if(item is DocumetType){
    switch (item){
      case DocumetType.CedulaDeCiudadania: return 'Cedula de ciudadania';
      case DocumetType.TarjetDeIdentidad: return 'Tarjet de identidad';
      case DocumetType.CedulaDeExtranjeria: return 'Cedula de etranjeria';
    }
  }else if(item is BloodType) {
    switch (item) {
      case BloodType.A_POS:
        return 'A+';
      case BloodType.O_POS:
        return 'O+';
      case BloodType.B_POS:
        return 'B+';
      case BloodType.AB_POS:
        return 'AB+';
      case BloodType.A_NEG:
        return 'A-';
      case BloodType.O_NEG:
        return 'O-';
      case BloodType.B_NEG:
        return 'B-';
      case BloodType.AB_NEG:
        return 'AB-';
    }
  } else if(item is RelationshipWithTheUniversity){
    switch (item){
      case RelationshipWithTheUniversity.estudent: return 'Estudiante';
      case RelationshipWithTheUniversity.professor: return 'Profesor';
      case RelationshipWithTheUniversity.universitary: return 'Unviersitario';
      case RelationshipWithTheUniversity.visitor: return 'Visitante';
    }
  }
  return item.toString().split('.').last; // Valor por defecto si no hay nombre personalizado
}