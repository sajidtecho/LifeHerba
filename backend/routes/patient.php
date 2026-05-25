<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Patient Routes
|--------------------------------------------------------------------------
|
| Here is where you can register patient routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('patient')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Patient module API endpoints.'
        ]);
    });
});
