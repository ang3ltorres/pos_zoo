import { getCurrentWindow, dialog, BrowserWindow, getGlobal } from '@electron/remote';
import { OpenDialogOptions } from 'electron';
import { readFileSync } from 'fs';
import Main from '../main';

let main: Main = getGlobal('main');
let aux: any = getGlobal('aux');

const categories: string[] = [
	'libro',
	'juguete',
	'ropa',
	'souvenir',
	'papeleria',
	'peluche',
	'accesorio',
	'artesania',
	'otro'
];

let categorySelect = document.getElementById('category') as HTMLSelectElement;
for (const c of categories) {
	let option = document.createElement('option') as HTMLOptionElement;
	option.value = c;
	option.text = c;
	categorySelect.add(option);
}

let buttonSupplier = document.getElementById('buttonSupplier') as HTMLButtonElement;
buttonSupplier.addEventListener('click', () => {

	let newAux = {...aux, selectEntryColumn: 'supplier', returnInputID: 'supplier'};
	main.setAux(newAux);

	main.createWindow(800, 600, 'gui/select_entry.html', getCurrentWindow());
	
});

// Add new product
let name = document.getElementById('name') as HTMLInputElement;
let description = document.getElementById('description') as HTMLInputElement;
let price = document.getElementById('price') as HTMLInputElement;
let category = document.getElementById('category') as HTMLInputElement;
let stock = document.getElementById('stock') as HTMLInputElement;
let maxStock = document.getElementById('maxStock') as HTMLInputElement;
let localLimit = document.getElementById('localLimit') as HTMLInputElement;
let supplier = document.getElementById('supplier') as HTMLInputElement;
let imagePath = document.getElementById('image') as HTMLInputElement;
let status = document.getElementById('status') as HTMLInputElement;

// Image preview
let buttonImage = document.getElementById('buttonImage') as HTMLButtonElement;
let imagePreview = document.getElementById('imagePreview') as HTMLImageElement;

const dialogOpenOptions: OpenDialogOptions = {title: 'Elegir imagen', properties: ['openFile']};

buttonImage.addEventListener('click', () => {
	let dialogResult: string[] = dialog.showOpenDialogSync(getCurrentWindow(), dialogOpenOptions);

	if (dialogResult != undefined)
	{
		imagePath.value = dialogResult[0];

		imagePreview.src = dialogResult[0];
		imagePreview.style.display = 'block';
	}
});

// Button accept
let buttonAccept = document.getElementById('buttonAccept') as HTMLButtonElement;

async function MAIN(): Promise<void> {

	// Add new product
	if (aux.action == 'a')
	{
		buttonAccept.addEventListener('click', async (): Promise<void> => {

			try {
				let imageRaw: string = readFileSync(imagePath.value, null).toString('base64');
				let query: string = `INSERT INTO PRODUCT VALUES((SELECT MAX(ID_PRODUCT) FROM PRODUCT) + 1, '${supplier.value}', '${name.value}', '${description.value}', '${price.value}', '${category.value}', '${stock.value}', '${maxStock.value}', '${localLimit.value}', DEFAULT, (DECODE('${imageRaw}', 'base64')));`;
				console.log(query);
				await main.querySQL(query);
		
			} catch (error: any) {
				console.log(error);
				dialog.showMessageBoxSync(getCurrentWindow(), {title: "Error", message: error.message, type: "error"});
			}
		
		});
	}
	// Modify product
	else if (aux.action == 'm')
	{
		// Get entry to modify
		let product: any = (await main.querySQL(`SELECT * FROM PRODUCT WHERE id_product = ${aux.id};`)).rows[0];

		// Populate inputs with existing info
		name.value = product.name;
		description.value = product.description;
		price.value = product.price;

		for (let i = 0; i < categories.length; i++)
			if (categories[i] == product.category) categorySelect.selectedIndex = i;

		stock.value = product.stock;
		maxStock.value = product.max_stock;
		localLimit.value = product.local_limit;
		supplier.value = product.fk_supplier;

		if (product.image) {

			imagePreview.src = URL.createObjectURL(new Blob([product.image.buffer], {type: "image/png"}));
			imagePreview.style.display = 'block';
		}

		status.checked = product.status;

		// Button event
		buttonAccept.addEventListener('click', async (): Promise<void> => {
		
			try {
				
				let imageRaw: string = null;
				if (imagePath.value != "")
					imageRaw = readFileSync(imagePath.value, null).toString('base64');

				let query =
				`UPDATE PRODUCT SET
				fk_supplier = '${supplier.value}', name = '${name.value}', description = '${description.value}',
				price = '${price.value}', category = '${category.value}', stock = '${stock.value}',
				max_stock = '${maxStock.value}', local_limit = '${localLimit.value}', status = '${status.checked}'`
				+ ((imageRaw) ? (`, image = (DECODE('${imageRaw}', 'base64')) WHERE id_product = ${aux.id};`) : (` WHERE id_product = ${aux.id};`));
				

				console.log(query);
				await main.querySQL(query);
		
			} catch (error: any) {
				console.log(error);
				dialog.showMessageBoxSync(getCurrentWindow(), {title: "Error", message: error.message, type: "error"});
			}
		
		});

	}

}
MAIN();