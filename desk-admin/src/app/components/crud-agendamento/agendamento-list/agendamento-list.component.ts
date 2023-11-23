import { Component, OnInit } from '@angular/core';
import { CrudService } from 'src/app/shared/services/crud.service';
import { agendamentos } from 'src/app/shared/agendamento';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-agendamento-list',
  templateUrl: './agendamento-list.component.html',
  styleUrls: ['./agendamento-list.component.scss']
})
export class AgendamentoListComponent implements OnInit {
  p: number = 1;
  Agendamento: agendamentos[];
  hideWhenNoAgendamento: boolean = false;
  noData: boolean = false;
  preLoader: boolean = true;
  actRoute: any;

  constructor(
    public crudApi: CrudService,
    public toastr: ToastrService
  ) { }

  async ngOnInit() {
    this.dataState();
    await this.crudApi.GetAgendamentoList().then((data: agendamentos[]) => {
      this.Agendamento = data.map(item => {
        const a = { ...(item as agendamentos), key: item.nomeCliente };
        return a;
      });
      this.preLoader = false;
    });
    console.log(this.Agendamento);
    
  }

  async dataState() {
    await this.crudApi.GetAgendamentoList().then(data => {
      if (data.length <= 0) {
        this.hideWhenNoAgendamento = false;
        this.noData = true;
      } else {
        this.hideWhenNoAgendamento = true;
        this.noData = false;
      }
    });
  }

  deleteAgendamento(agendamento:any ) {
    console.log(agendamento.id)
    if (window.confirm('Você tem certeza que deseja apagar esse agendamento ?')) {
      this.crudApi.DeleteAgendamento(agendamento.id);
      this.toastr.success(agendamento.info.nomeCliente + ' Deletado com sucesso! ');
    }
  }
}
