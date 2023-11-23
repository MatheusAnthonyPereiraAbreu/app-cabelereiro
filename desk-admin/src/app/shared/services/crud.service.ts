import { Injectable } from '@angular/core';
import { AngularFirestore, AngularFirestoreCollection, AngularFirestoreDocument } from '@angular/fire/compat/firestore';
import { Observable } from 'rxjs';
import { agendamentos } from '../agendamento';
import { collection, deleteDoc, doc, getDocs, getFirestore, query } from 'firebase/firestore';
import { AuthService } from './auth.services';

@Injectable({
  providedIn: 'root',
})
export class CrudService {
  agendamentosCollection: AngularFirestoreCollection<agendamentos>;
  agendamentoDoc: AngularFirestoreDocument<agendamentos>;
  agendamentoRef: any;
  key: string;
  constructor(
    private afs: AngularFirestore
  ) {
    this.agendamentosCollection = this.afs.collection('agendamentos');
  }
  // Criar Agendamento
  async AddAgendamento(agenda: agendamentos) {
    await this.agendamentosCollection.add({
      nomeCliente: agenda.nomeCliente,
      data: agenda.data,
      horario: agenda.horario,
      servico: agenda.servico,
      cabelereiro: agenda.cabelereiro,
    })

  }
  // Obter Agendamento por ID
  async GetAgendamento(key: string): Promise<AngularFirestoreDocument<agendamentos>> {
    await this.agendamentoRef; this.afs.doc('agendamentos/' + key);
    return this.agendamentoRef;
  }
  // Obter Lista de Agendamentos
  async GetAgendamentoList(): Promise<any[]> {
    const db = getFirestore()
    const q = query(collection(db, "agendamentos"))
    let agendamentos = [ ]
    await getDocs(q).then((snapshot) => {
      snapshot.forEach((doc) => {
        agendamentos.push({
          id:doc.id,
          info: doc.data()
        })
      }
      )
    
    })
    return agendamentos;
  }
  // Atualizar Agendamento
  async UpdateAgendamento(agenda: agendamentos , key:string) {
    this.agendamentoDoc = this.afs.doc('agendamentos/'+ key)
    await this.agendamentoDoc.update({
      data: agenda.data,
      nomeCliente: agenda.nomeCliente,
      horario: agenda.horario,
      servico: agenda.servico,
      cabelereiro: agenda.cabelereiro,
    });
  }
  // Deletar Agendamento
  async DeleteAgendamento(key:string) {
    await this.afs.doc('agendamentos/' + key).delete();
    window.location.reload()
  }
}