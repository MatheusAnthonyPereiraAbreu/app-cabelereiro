import { Component } from '@angular/core';
import { AuthService } from 'src/app/shared/services/auth.services';
// import { AdmUser, UserServices } from 'src/app/shared/services/user.services';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
  export class DashboardComponent {
    constructor(
      public authService: AuthService,
      ) {}
    imagePath: string = 'assets/foto1.png';
    imagePath2:string = 'assets/foto2.png';
    imagePath3:string = 'assets/foto3.png';
    spaIcon:string = 'assets/spa-icon.svg';

  ngOnInit(): void {}
}
