
import { AngularFirestore } from "@angular/fire/compat/firestore";
import { Timestamp } from "firebase/firestore";

export interface agendamentos {
   cabelereiro:string;
   data:Timestamp;
   horario:string;
   nomeCliente:string;
   servico:string;
}